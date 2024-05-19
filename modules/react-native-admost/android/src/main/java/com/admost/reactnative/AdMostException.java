package com.admost.reactnative;

public class AdMostException extends RuntimeException {
  private String message;

  public AdMostException(String message) {
    super(message);
    this.message = message;
  }

  @Override
  public String getMessage() {
    return message;
  }
}
